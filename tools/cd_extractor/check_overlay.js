const fs = require("fs");
const exePath = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
const buf = fs.readFileSync(exePath);
const overlayOffset = 1081344; // 0x108000

console.log("Overlay header hex:");
console.log(buf.subarray(overlayOffset, overlayOffset + 64).toString("hex"));
console.log("Overlay header ascii:");
console.log(buf.subarray(overlayOffset, overlayOffset + 64).toString("latin1"));

// Check if there are known archive formats or Flash Projector structure
// In Adobe Flash Projector:
// At the end of the file or at overlay:
// Byte 0-2: "FWS" or "CWS"
// Or at the end of the file: 4-byte length + 0xFA3460FA
const tail = buf.subarray(buf.length - 32);
console.log("File tail hex:", tail.toString("hex"));
console.log("File tail ascii:", tail.toString("latin1"));
