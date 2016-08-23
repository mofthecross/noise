const bluebird = require('bluebird');
const client = require('../redis').client;
const request = require('request');
const fs = bluebird.promisifyAll(require('fs'));

const { bigEndianEncode, getBloomFilterBit } = require('./dpUtility');

const {
  BLOOM_FILTER_SIZE,
  NUM_HASH_FUNCTIONS,
  NUM_COHORTS,
  P_PARAM,
  Q_PARAM,
  F_PARAM,
  MAX_SUM_BITS,
} = require('./dpParams');

// Config
const ANALYSIS_SERVER = 'http://localhost:8004';

// Generate the counts file containing the total number of reports and bit sums
// for each cohort.
// Returns a Promise that is resolved with the string contents of the counts file.
function generateCountsString() {
  // Perform one batch query for each cohort
  const queries = [...Array(NUM_COHORTS).keys()].map(cohortNum => {
    const commands = [];

    // Get this cohort's total number of reports
    commands.push(['HMGET', 'repTotals', `coh${cohortNum}`]);

    // Get this cohort's sums for each bit position
    [...Array(BLOOM_FILTER_SIZE).keys()].forEach(bitPos => {
      commands.push(['BITFIELD', `bitCounts:${cohortNum}`, 'GET', `u${MAX_SUM_BITS}`, `#${bitPos}`]);
    });

    return client.batch(commands).execAsync();
  });

  return Promise.all(queries)
    .then(rows => {
      return rows.map(row => row.join(',')).join('\n')
    });
}

// Given an Array of candidate strings, generate the map file containing
// each candidate string and the bits that they map to in each cohort.
// Each line starts with the candidate string, followed by the bit positions
// that each string maps to in each cohort. In order to distinguish bit positions
// in different cohorts, we multiply the cohort number by the bloom filter size
// and then add the bit position.
// Returns a string representing the contents of the map file.
function generateMapString(candidateStrings) {
  const lines = candidateStrings.map(string => {
    const positions = [string];

    [...Array(NUM_COHORTS).keys()].forEach(cohortNum => {
      [...Array(NUM_HASH_FUNCTIONS).keys()].forEach(hashNum => {
        const bitPos = getBloomFilterBit(string, cohortNum, hashNum) + 1;
        positions.push(cohortNum * BLOOM_FILTER_SIZE + bitPos);
      });
    });

    return positions.join(',');
  });

  return lines.join('\n');
}

// Returns a string representing the contents of the RAPPOR params file,
// using the parameters set in dpParams.js.
function generateParamsString() {
  const params = [
    BLOOM_FILTER_SIZE,
    NUM_HASH_FUNCTIONS,
    NUM_COHORTS,
    P_PARAM,
    Q_PARAM,
    F_PARAM,
  ];

  return `k,h,m,p,q,f\n${params.join(',')}\n`
}

// Given an Array of candidate strings, using aggregated data in Redis,
// returns a Promise that is resolved with an object describing the results
// of the analysis.
function performDPAnalysis(candidateStrings) {
  // Generate file bodies
  return Promise.all([
      generateCountsString(),
      generateMapString(candidateStrings),
      generateParamsString(),
    ])
    .then(([countsString, mapString, paramsString]) => {
      // Write files
      return Promise.all([
        fs.writeFileAsync('./analysis-server/tmp/counts.csv', countsString),
        fs.writeFileAsync('./analysis-server/tmp/map.csv', mapString),
        fs.writeFileAsync('./analysis-server/tmp/params.csv', paramsString),
      ]);
    })
    .then(() => {
      // Submit POST request
      const formData = {};

      ['counts', 'map', 'params'].forEach(fileName => {
        formData[fileName] = {
          value: fs.createReadStream(`./analysis-server/tmp/case_${fileName}.csv`),
          options: {
            filename: `case_${fileName}.csv`,
            contentType: 'text/csv',
          },
        };
      });

      return new Promise((resolve, reject) => {
        request.post({ url: `${ANALYSIS_SERVER}/ocpu/library/rappor/R/Decode`, formData }, (err, res, body) => {
          if (err) reject(err);
          resolve(body);
        });
      });
    })
    .then(body => {
      // Retrieve JSON results
      const bodyLines = body.split('\n');
      const resultsJSONPath = bodyLines.find(line => line.includes('results.json'));

      return new Promise((resolve, reject) => {
        request(`${ANALYSIS_SERVER}${resultsJSONPath}`, (err, res, body) => {
          if (err) reject(err);
          resolve(body);
        });
      });
    })
    .then(json => {
      // Return parsed JSON
      return JSON.parse(json);
    })
    .catch(console.error.bind.console);
}

// Exports
module.exports = {
  performDPAnalysis,
};

const sampleCandidateStrings = ['v1', 'v2', 'v3', 'v4', 'v5', 'v6', 'v7', 'v8', 'v9', 'v10', 'v11', 'v12', 'v13', 'v14', 'v15', 'v16', 'v17', 'v18', 'v19', 'v20',
  'v21', 'v22', 'v23', 'v24', 'v25', 'v26', 'v27', 'v28', 'v29', 'v30', 'v31', 'v32', 'v33', 'v34', 'v35', 'v36', 'v37', 'v38', 'v39', 'v40', 'v41', 'v42', 'v43',
  'v44', 'v45', 'v46', 'v47', 'v48', 'v49', 'v50', 'v51', 'v52', 'v53', 'v54', 'v55', 'v56', 'v57', 'v58', 'v59', 'v60', 'v61', 'v62', 'v63', 'v64', 'v65', 'v66',
  'v67', 'v68', 'v69', 'v70', 'v71', 'v72', 'v73', 'v74', 'v75', 'v76', 'v77', 'v78', 'v79', 'v80', 'v81', 'v82', 'v83', 'v84', 'v85', 'v86', 'v87', 'v88', 'v89',
  'v90', 'v91', 'v92', 'v93', 'v94', 'v95', 'v96', 'v97', 'v98', 'v99', 'v100', 'v101', 'v102', 'v103', 'v104', 'v105', 'v106', 'v107', 'v108', 'v109', 'v110',
  'v111', 'v112', 'v113', 'v114', 'v115', 'v116', 'v117', 'v118', 'v119', 'v120', 'v121', 'v122', 'v123', 'v124', 'v125', 'v126', 'v127', 'v128', 'v129', 'v130',
  'v131', 'v132', 'v133', 'v134', 'v135', 'v136', 'v137', 'v138', 'v139', 'v140', 'v141', 'v142', 'v143', 'v144', 'v145', 'v146', 'v147', 'v148', 'v149', 'v150',
  'v151', 'v152', 'v153', 'v154', 'v155', 'v156', 'v157', 'v158', 'v159', 'v160', 'v161', 'v162', 'v163', 'v164', 'v165', 'v166', 'v167', 'v168', 'v169', 'v170',
  'v171', 'v172', 'v173', 'v174', 'v175', 'v176', 'v177', 'v178', 'v179', 'v180', 'v181', 'v182', 'v183', 'v184', 'v185', 'v186', 'v187', 'v188', 'v189', 'v190',
  'v191', 'v192', 'v193', 'v194', 'v195', 'v196', 'v197', 'v198', 'v199', 'v200'];

// performDPAnalysis(sampleCandidateStrings);
