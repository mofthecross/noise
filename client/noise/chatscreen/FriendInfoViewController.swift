import UIKit
import Locksmith
import RealmSwift

let reusableCell = "FriendInfoCell"

class FriendInfoViewController: UITableViewController{
    let realm = try! Realm()
    var friendInfo = Friend()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        print("printing friendInfo on friendinfo ", self.friendInfo)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reusableCell)
    }
}

// navigation
extension FriendInfoViewController {
    func setUp() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        self.title = "info"
    }
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// other methods
extension FriendInfoViewController {
    func generateWord(num: Int) -> Int {
        return num % wordsArray.count
    }
}

// UI configurations
extension FriendInfoViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Human Readable Key:"
        case 1:
            return "Somthing else"
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableCell)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let getUserID = realm.objects(User)[0]["userID"]
                let dummySharedKey = 1194310654 // to be deleted when getUserKeyWorks
                _ = Locksmith.loadDataForUserAccount("noise:'\(getUserID!["sharedKey"])")
                
                cell!.textLabel?.text = wordsArray[generateWord(dummySharedKey)]
                
            default:
                break
            }
        default:
            break
        }
        return cell!
    }
}


private let wordsArray  = [ "nil",
                    "academy",  "acrobat",  "active",   "actor",    "adam",     "admiral",
                    "adrian",   "africa",   "agenda",   "agent",    "airline",  "airport",
                    "aladdin",  "alarm",    "alaska",   "albert",   "albino",   "album",
                    "alcohol",  "alex",     "algebra",  "alibi",    "alice",    "alien",
                    "alpha",    "alpine",   "amadeus",  "amanda",   "amazon",   "amber",
                    "america",  "amigo",    "analog",   "anatomy",  "angel",    "animal",
                    "antenna",  "antonio",  "apollo",   "april",    "archive",  "arctic",
                    "arizona",  "arnold",   "aroma",    "arthur",   "artist",   "asia",
                    "aspect",   "aspirin",  "athena",   "athlete",  "atlas",    "audio",
                    "august",   "austria",  "axiom",    "aztec",    "balance",  "ballad",
                    "banana",   "bandit",   "banjo",    "barcode",  "baron",    "basic",
                    "battery",  "belgium",  "berlin",   "bermuda",  "bernard",  "bikini",
                    "binary",   "bingo",    "biology",  "block",    "blonde",   "bonus",
                    "boris",    "boston",   "boxer",    "brandy",   "bravo",    "brazil",
                    "bronze",   "brown",    "bruce",    "bruno",    "burger",   "burma",
                    "cabinet",  "cactus",   "cafe",     "cairo",    "cake",     "calypso",
                    "camel",    "camera",   "campus",   "canada",   "canal",    "cannon",
                    "canoe",    "cantina",  "canvas",   "canyon",   "capital",  "caramel",
                    "caravan",  "carbon",   "cargo",    "carlo",    "carol",    "carpet",
                    "cartel",   "casino",   "castle",   "castro",   "catalog",  "caviar",
                    "cecilia",  "cement",   "center",   "century",  "ceramic",  "chamber",
                    "chance",   "change",   "chaos",    "charlie",  "charm",    "charter",
                    "chef",     "chemist",  "cherry",   "chess",    "chicago",  "chicken",
                    "chief",    "china",    "cigar",    "cinema",   "circus",   "citizen",
                    "city",     "clara",    "classic",  "claudia",  "clean",    "client",
                    "climax",   "clinic",   "clock",    "club",     "cobra",    "coconut",
                    "cola",     "collect",  "colombo",  "colony",   "color",    "combat",
                    "comedy",   "comet",    "command",  "compact",  "company",  "complex",
                    "concept",  "concert",  "connect",  "consul",   "contact",  "context",
                    "contour",  "control",  "convert",  "copy",     "corner",   "corona",
                    "correct",  "cosmos",   "couple",   "courage",  "cowboy",   "craft",
                    "crash",    "credit",   "cricket",  "critic",   "crown",    "crystal",
                    "cuba",     "culture",  "dallas",   "dance",    "daniel",   "david",
                    "decade",   "decimal",  "deliver",  "delta",    "deluxe",   "demand",
                    "demo",     "denmark",  "derby",    "design",   "detect",   "develop",
                    "diagram",  "dialog",   "diamond",  "diana",    "diego",    "diesel",
                    "diet",     "digital",  "dilemma",  "diploma",  "direct",   "disco",
                    "disney",   "distant",  "doctor",   "dollar",   "dominic",  "domino",
                    "donald",   "dragon",   "drama",    "dublin",   "duet",     "dynamic",
                    "east",     "ecology",  "economy",  "edgar",    "egypt",    "elastic",
                    "elegant",  "element",  "elite",    "elvis",    "email",    "energy",
                    "engine",   "english",  "episode",  "equator",  "escort",   "ethnic",
                    "europe",   "everest",  "evident",  "exact",    "example",  "exit",
                    "exotic",   "export",   "express",  "extra",    "fabric",   "factor",
                    "falcon",   "family",   "fantasy",  "fashion",  "fiber",    "fiction",
                    "fidel",    "fiesta",   "figure",   "film",     "filter",   "final",
                    "finance",  "finish",   "finland",  "flash",    "florida",  "flower",
                    "fluid",    "flute",    "focus",    "ford",     "forest",   "formal",
                    "format",   "formula",  "fortune",  "forum",    "fragile",  "france",
                    "frank",    "friend",   "frozen",   "future",   "gabriel",  "galaxy",
                    "gallery",  "gamma",    "garage",   "garden",   "garlic",   "gemini",
                    "general",  "genetic",  "genius",   "germany",  "global",   "gloria",
                    "golf",     "gondola",  "gong",     "good",     "gordon",   "gorilla",
                    "grand",    "granite",  "graph",    "green",    "group",    "guide",
                    "guitar",   "guru",     "hand",     "happy",    "harbor",   "harmony",
                    "harvard",  "havana",   "hawaii",   "helena",   "hello",    "henry",
                    "hilton",   "history",  "horizon",  "hotel",    "human",    "humor",
                    "icon",     "idea",     "igloo",    "igor",     "image",    "impact",
                    "import",   "index",    "india",    "indigo",   "input",    "insect",
                    "instant",  "iris",     "italian",  "jacket",   "jacob",    "jaguar",
                    "janet",    "japan",    "jargon",   "jazz",     "jeep",     "john",
                    "joker",    "jordan",   "jumbo",    "june",     "jungle",   "junior",
                    "jupiter",  "karate",   "karma",    "kayak",    "kermit",   "kilo",
                    "king",     "koala",    "korea",    "labor",    "lady",     "lagoon",
                    "laptop",   "laser",    "latin",    "lava",     "lecture",  "left",
                    "legal",    "lemon",    "level",    "lexicon",  "liberal",  "libra",
                    "limbo",    "limit",    "linda",    "linear",   "lion",     "liquid",
                    "liter",    "little",   "llama",    "lobby",    "lobster",  "local",
                    "logic",    "logo",     "lola",     "london",   "lotus",    "lucas",
                    "lunar",    "machine",  "macro",    "madam",    "madonna",  "madrid",
                    "maestro",  "magic",    "magnet",   "magnum",   "major",    "mama",
                    "mambo",    "manager",  "mango",    "manila",   "marco",    "marina",
                    "market",   "mars",     "martin",   "marvin",   "master",   "matrix",
                    "maximum",  "media",    "medical",  "mega",     "melody",   "melon",
                    "memo",     "mental",   "mentor",   "menu",     "mercury",  "message",
                    "metal",    "meteor",   "meter",    "method",   "metro",    "mexico",
                    "miami",    "micro",    "million",  "mineral",  "minimum",  "minus",
                    "minute",   "miracle",  "mirage",   "miranda",  "mister",   "mixer",
                    "mobile",   "model",    "modem",    "modern",   "modular",  "moment",
                    "monaco",   "monica",   "monitor",  "mono",     "monster",  "montana",
                    "morgan",   "motel",    "motif",    "motor",    "mozart",   "multi",
                    "museum",   "music",    "mustang",  "natural",  "neon",     "nepal",
                    "neptune",  "nerve",    "neutral",  "nevada",   "news",     "ninja",
                    "nirvana",  "normal",   "nova",     "novel",    "nuclear",  "numeric",
                    "nylon",    "oasis",    "object",   "observe",  "ocean",    "octopus",
                    "olivia",   "olympic",  "omega",    "opera",    "optic",    "optimal",
                    "orange",   "orbit",    "organic",  "orient",   "origin",   "orlando",
                    "oscar",    "oxford",   "oxygen",   "ozone",    "pablo",    "pacific",
                    "pagoda",   "palace",   "pamela",   "panama",   "panda",    "panel",
                    "panic",    "paradox",  "pardon",   "paris",    "parker",   "parking",
                    "parody",   "partner",  "passage",  "passive",  "pasta",    "pastel",
                    "patent",   "patriot",  "patrol",   "patron",   "pegasus",  "pelican",
                    "penguin",  "pepper",   "percent",  "perfect",  "perfume",  "period",
                    "permit",   "person",   "peru",     "phone",    "photo",    "piano",
                    "picasso",  "picnic",   "picture",  "pigment",  "pilgrim",  "pilot",
                    "pirate",   "pixel",    "pizza",    "planet",   "plasma",   "plaster",
                    "plastic",  "plaza",    "pocket",   "poem",     "poetic",   "poker",
                    "polaris",  "police",   "politic",  "polo",     "polygon",  "pony",
                    "popcorn",  "popular",  "postage",  "postal",   "precise",  "prefix",
                    "premium",  "present",  "price",    "prince",   "printer",  "prism",
                    "private",  "product",  "profile",  "program",  "project",  "protect",
                    "proton",   "public",   "pulse",    "puma",     "pyramid",  "queen",
                    "radar",    "radio",    "random",   "rapid",    "rebel",    "record",
                    "recycle",  "reflex",   "reform",   "regard",   "regular",  "relax",
                    "report",   "reptile",  "reverse",  "ricardo",  "ringo",    "ritual",
                    "robert",   "robot",    "rocket",   "rodeo",    "romeo",    "royal",
                    "russian",  "safari",   "salad",    "salami",   "salmon",   "salon",
                    "salute",   "samba",    "sandra",   "santana",  "sardine",  "school",
                    "screen",   "script",   "second",   "secret",   "section",  "segment",
                    "select",   "seminar",  "senator",  "senior",   "sensor",   "serial",
                    "service",  "sheriff",  "shock",    "sierra",   "signal",   "silicon",
                    "silver",   "similar",  "simon",    "single",   "siren",    "slogan",
                    "social",   "soda",     "solar",    "solid",    "solo",     "sonic",
                    "soviet",   "special",  "speed",    "spiral",   "spirit",   "sport",
                    "static",   "station",  "status",   "stereo",   "stone",    "stop",
                    "street",   "strong",   "student",  "studio",   "style",    "subject",
                    "sultan",   "super",    "susan",    "sushi",    "suzuki",   "switch",
                    "symbol",   "system",   "tactic",   "tahiti",   "talent",   "tango",
                    "tarzan",   "taxi",     "telex",    "tempo",    "tennis",   "texas",
                    "textile",  "theory",   "thermos",  "tiger",    "titanic",  "tokyo",
                    "tomato",   "topic",    "tornado",  "toronto",  "torpedo",  "total",
                    "totem",    "tourist",  "tractor",  "traffic",  "transit",  "trapeze",
                    "travel",   "tribal",   "trick",    "trident",  "trilogy",  "tripod",
                    "tropic",   "trumpet",  "tulip",    "tuna",     "turbo",    "twist",
                    "ultra",    "uniform",  "union",    "uranium",  "vacuum",   "valid",
                    "vampire",  "vanilla",  "vatican",  "velvet",   "ventura",  "venus",
                    "vertigo",  "veteran",  "victor",   "video",    "vienna",   "viking",
                    "village",  "vincent",  "violet",   "violin",   "virtual",  "virus",
                    "visa",     "vision",   "visitor",  "visual",   "vitamin",  "viva",
                    "vocal",    "vodka",    "volcano",  "voltage",  "volume",   "voyage",
                    "water",    "weekend",  "welcome",  "western",  "window",   "winter",
                    "wizard",   "wolf",     "world",    "xray",     "yankee",   "yoga",
                    "yogurt",   "yoyo",     "zebra",    "zero",     "zigzag",   "zipper",
                    "zodiac",   "zoom",     "abraham",  "action",   "address",  "alabama",
                    "alfred",   "almond",   "ammonia",  "analyze",  "annual",   "answer",
                    "apple",    "arena",    "armada",   "arsenal",  "atlanta",  "atomic",
                    "avenue",   "average",  "bagel",    "baker",    "ballet",   "bambino",
                    "bamboo",   "barbara",  "basket",   "bazaar",   "benefit",  "bicycle",
                    "bishop",   "blitz",    "bonjour",  "bottle",   "bridge",   "british",
                    "brother",  "brush",    "budget",   "cabaret",  "cadet",    "candle",
                    "capitan",  "capsule",  "career",   "cartoon",  "channel",  "chapter",
                    "cheese",   "circle",   "cobalt",   "cockpit",  "college",  "compass",
                    "comrade",  "condor",   "crimson",  "cyclone",  "darwin",   "declare",
                    "degree",   "delete",   "delphi",   "denver",   "desert",   "divide",
                    "dolby",    "domain",   "domingo",  "double",   "drink",    "driver",
                    "eagle",    "earth",    "echo",     "eclipse",  "editor",   "educate",
                    "edward",   "effect",   "electra",  "emerald",  "emotion",  "empire",
                    "empty",    "escape",   "eternal",  "evening",  "exhibit",  "expand",
                    "explore",  "extreme",  "ferrari",  "first",    "flag",     "folio",
                    "forget",   "forward",  "freedom",  "fresh",    "friday",   "fuji",
                    "galileo",  "garcia",   "genesis",  "gold",     "gravity",  "habitat",
                    "hamlet",   "harlem",   "helium",   "holiday",  "house",    "hunter",
                    "ibiza",    "iceberg",  "imagine",  "infant",   "isotope",  "jackson",
                    "jamaica",  "jasmine",  "java",     "jessica",  "judo",     "kitchen",
                    "lazarus",  "letter",   "license",  "lithium",  "loyal",    "lucky",
                    "magenta",  "mailbox",  "manual",   "marble",   "mary",     "maxwell",
                    "mayor",    "milk",     "monarch",  "monday",   "money",    "morning",
                    "mother",   "mystery",  "native",   "nectar",   "nelson",   "network",
                    "next",     "nikita",   "nobel",    "nobody",   "nominal",  "norway",
                    "nothing",  "number",   "october",  "office",   "oliver",   "opinion",
                    "option",   "order",    "outside",  "package",  "pancake",  "pandora",
                    "panther",  "papa",     "patient",  "pattern",  "pedro",    "pencil",
                    "people",   "phantom",  "philips",  "pioneer",  "pluto",    "podium",
                    "portal",   "potato",   "prize",    "process",  "protein",  "proxy",
                    "pump",     "pupil",    "python",   "quality",  "quarter",  "quiet",
                    "rabbit",   "radical",  "radius",   "rainbow",  "ralph",    "ramirez",
                    "ravioli",  "raymond",  "respect",  "respond",  "result",   "resume",
                    "retro",    "richard",  "right",    "risk",     "river",    "roger",
                    "roman",    "rondo",    "sabrina",  "salary",   "salsa",    "sample",
                    "samuel",   "saturn",   "savage",   "scarlet",  "scoop",    "scorpio",
                    "scratch",  "scroll",   "sector",   "serpent",  "shadow",   "shampoo",
                    "sharon",   "sharp",    "short",    "shrink",   "silence",  "silk",
                    "simple",   "slang",    "smart",    "smoke",    "snake",    "society",
                    "sonar",    "sonata",   "soprano",  "source",   "sparta",   "sphere",
                    "spider",   "sponsor",  "spring",   "acid",     "adios",    "agatha",
                    "alamo",    "alert",    "almanac",  "aloha",    "andrea",   "anita",
                    "arcade",   "aurora",   "avalon",   "baby",     "baggage",  "balloon",
                    "bank",     "basil",    "begin",    "biscuit",  "blue",     "bombay",
                    "brain",    "brenda",   "brigade",  "cable",    "carmen",   "cello",
                    "celtic",   "chariot",  "chrome",   "citrus",   "civil",    "cloud",
                    "common",   "compare",  "cool",     "copper",   "coral",    "crater",
                    "cubic",    "cupid",    "cycle",    "depend",   "door",     "dream",
                    "dynasty",  "edison",   "edition",  "enigma",   "equal",    "eric",
                    "event",    "evita",    "exodus",   "extend",   "famous",   "farmer",
                    "food",     "fossil",   "frog",     "fruit",    "geneva",   "gentle",
                    "george",   "giant",    "gilbert",  "gossip",   "gram",     "greek",
                    "grille",   "hammer",   "harvest",  "hazard",   "heaven",   "herbert",
                    "heroic",   "hexagon",  "husband",  "immune",   "inca",     "inch",
                    "initial",  "isabel",   "ivory",    "jason",    "jerome",   "joel",
                    "joshua",   "journal",  "judge",    "juliet",   "jump",     "justice",
                    "kimono",   "kinetic",  "leonid",   "lima",     "maze",     "medusa",
                    "member",   "memphis",  "michael",  "miguel",   "milan",    "mile",
                    "miller",   "mimic",    "mimosa",   "mission",  "monkey",   "moral",
                    "moses",    "mouse",    "nancy",    "natasha",  "nebula",   "nickel",
                    "nina",     "noise",    "orchid",   "oregano",  "origami",  "orinoco",
                    "orion",    "othello",  "paper",    "paprika",  "prelude",  "prepare",
                    "pretend",  "profit",   "promise",  "provide",  "puzzle",   "remote",
                    "repair",   "reply",    "rival",    "riviera",  "robin",    "rose",
                    "rover",    "rudolf",   "saga",     "sahara",   "scholar",  "shelter",
                    "ship",     "shoe",     "sigma",    "sister",   "sleep",    "smile",
                    "spain",    "spark",    "split",    "spray",    "square",   "stadium",
                    "star",     "storm",    "story",    "strange",  "stretch",  "stuart",
                    "subway",   "sugar",    "sulfur",   "summer",   "survive",  "sweet",
                    "swim",     "table",    "taboo",    "target",   "teacher",  "telecom",
                    "temple",   "tibet",    "ticket",   "tina",     "today",    "toga",
                    "tommy",    "tower",    "trivial",  "tunnel",   "turtle",   "twin",
                    "uncle",    "unicorn",  "unique",   "update",   "valery",   "vega",
                    "version",  "voodoo",   "warning",  "william",  "wonder",   "year",
                    "yellow",   "young",    "absent",   "absorb",   "accent",   "alfonso",
                    "alias",    "ambient",  "andy",     "anvil",    "appear",   "apropos",
                    "archer",   "ariel",    "armor",    "arrow",    "austin",   "avatar",
                    "axis",     "baboon",   "bahama",   "bali",     "balsa",    "bazooka",
                    "beach",    "beast",    "beatles",  "beauty",   "before",   "benny",
                    "betty",    "between",  "beyond",   "billy",    "bison",    "blast",
                    "bless",    "bogart",   "bonanza",  "book",     "border",   "brave",
                    "bread",    "break",    "broken",   "bucket",   "buenos",   "buffalo",
                    "bundle",   "button",   "buzzer",   "byte",     "caesar",   "camilla",
                    "canary",   "candid",   "carrot",   "cave",     "chant",    "child",
                    "choice",   "chris",    "cipher",   "clarion",  "clark",    "clever",
                    "cliff",    "clone",    "conan",    "conduct",  "congo",    "content",
                    "costume",  "cotton",   "cover",    "crack",    "current",  "danube",
                    "data",     "decide",   "desire",   "detail",   "dexter",   "dinner",
                    "dispute",  "donor",    "druid",    "drum",     "easy",     "eddie",
                    "enjoy",    "enrico",   "epoxy",    "erosion",  "except",   "exile",
                    "explain",  "fame",     "fast",     "father",   "felix",    "field",
                    "fiona",    "fire",     "fish",     "flame",    "flex",     "flipper",
                    "float",    "flood",    "floor",    "forbid",   "forever",  "fractal",
                    "frame",    "freddie",  "front",    "fuel",     "gallop",   "game",
                    "garbo",    "gate",     "gibson",   "ginger",   "giraffe",  "gizmo",
                    "glass",    "goblin",   "gopher",   "grace",    "gray",     "gregory",
                    "grid",     "griffin",  "ground",   "guest",    "gustav",   "gyro",
                    "hair",     "halt",     "harris",   "heart",    "heavy",    "herman",
                    "hippie",   "hobby",    "honey",    "hope",     "horse",    "hostel",
                    "hydro",    "imitate",  "info",     "ingrid",   "inside",   "invent",
                    "invest",   "invite",   "iron",     "ivan",     "james",    "jester",
                    "jimmy",    "join",     "joseph",   "juice",    "julius",   "july",
                    "justin",   "kansas",   "karl",     "kevin",    "kiwi",     "ladder",
                    "lake",     "laura",    "learn",    "legacy",   "legend",   "lesson",
                    "life",     "light",    "list",     "locate",   "lopez",    "lorenzo",
                    "love",     "lunch",    "malta",    "mammal",   "margo",    "marion",
                    "mask",     "match",    "mayday",   "meaning",  "mercy",    "middle",
                    "mike",     "mirror",   "modest",   "morph",    "morris",   "nadia",
                    "nato",     "navy",     "needle",   "neuron",   "never",    "newton",
                    "nice",     "night",    "nissan",   "nitro",    "nixon",    "north",
                    "oberon",   "octavia",  "ohio",     "olga",     "open",     "opus",
                    "orca",     "oval",     "owner",    "page",     "paint",    "palma",
                    "parade",   "parent",   "parole",   "paul",     "peace",    "pearl",
                    "perform",  "phoenix",  "phrase",   "pierre",   "pinball",  "place",
                    "plate",    "plato",    "plume",    "pogo",     "point",    "polite",
                    "polka",    "poncho",   "powder",   "prague",   "press",    "presto",
                    "pretty",   "prime",    "promo",    "quasi",    "quest",    "quick",
                    "quiz",     "quota",    "race",     "rachel",   "raja",     "ranger",
                    "region",   "remark",   "rent",     "reward",   "rhino",    "ribbon",
                    "rider",    "road",     "rodent",   "round",    "rubber",   "ruby",
                    "rufus",    "sabine",   "saddle",   "sailor",   "saint",    "salt",
                    "satire",   "scale",    "scuba",    "season",   "secure",   "shake",
                    "shallow",  "shannon",  "shave",    "shelf",    "sherman",  "shine",
                    "shirt",    "side",     "sinatra",  "sincere",  "size",     "slalom",
                    "slow",     "small",    "snow",     "sofia",    "song",     "sound",
                    "south",    "speech",   "spell",    "spend",    "spoon",    "stage",
                    "stamp",    "stand",    "state",    "stella",   "stick",    "sting",
                    "stock",    "store",    "sunday",   "sunset",   "support",  "sweden",
                    "swing",    "tape",     "think",    "thomas",   "tictac",   "time",
                    "toast",    "tobacco",  "tonight",  "torch",    "torso",    "touch",
                    "toyota",   "trade",    "tribune",  "trinity",  "triton",   "truck",
                    "trust",    "type",     "under",    "unit",     "urban",    "urgent",
                    "user",     "value",    "vendor",   "venice",   "verona",   "vibrate",
                    "virgo",    "visible",  "vista",    "vital",    "voice",    "vortex",
                    "waiter",   "watch",    "wave",     "weather",  "wedding",  "wheel",
                    "whiskey",  "wisdom",   "deal",     "null",     "nurse",    "quebec",
                    "reserve",  "reunion",  "roof",     "singer",   "verbal",   "amen",
                    "ego",      "fax",      "jet",      "job",      "rio",      "ski",
                    "yes"
]

//let wordIndexDictionary = Dictionary<String, Int>()
//func generateWordIndexDictionary(inputWord: String) -> Int {
//    if (wordIndexDictionary.isEmpty) {
//        wordIndexDictionary = [:]
//
//        for (index, word) in wordsArray.enumerate() {
//            wordIndexDictionary["\(word.lowercaseString)"] = index
//        }
//    }
//    return wordIndexDictionary["\(inputWord)"]!
//}

//print(wordsArray[generateWord(1194310654)])