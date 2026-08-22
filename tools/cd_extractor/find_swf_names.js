const fs = require("fs");
const exePath = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
const buf = fs.readFileSync(exePath);

// Search for any strings containing .swf or ahdaf
const str = buf.toString("latin1");
const swfRegex = /[\w\d_\-\.]+\.swf/gi;
const matches = new Set();
let m;
while ((m = swfRegex.exec(str)) !== null) {
  matches.add(m[0]);
}

console.log("Found SWF filenames in EXE:");
Array.from(matches).sort().forEach(name => console.log(" -", name));
