import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;

/**
 * BuildSceneImages.java
 * Extracts the best full-scene frame from each SWF export,
 * removes ONLY the top CD navigation bar (first 36px at 800x600),
 * keeping everything else: scene title, tree hollow, illustration, word text, bottom train bar.
 * This matches exactly the approach used for Alif scene images.
 */
public class BuildSceneImages {

    // Remove only the CD navigation bar (top 36px).
    // Keep everything below: scene title + hollow + illustration + word + train bar.
    static final int NAV_BAR_H = 36;

    public static void main(String[] args) throws Exception {
        // baqara: frame 300 shows the cow clearly in the hollow
        processSpecific("scratch/bakra1_frames", 300,
            "assets/images/lessons/baa/sounds/baqara.png");

        // thoaban: frame 100 shows the snake. Title says "الباء الممدود" but
        // the snake image is authentic. We'll crop an extra 60px from the top
        // to remove the misleading title, keeping only the hollow + snake + word.
        processThoaban("scratch/thoaban_frames", 100,
            "assets/images/lessons/baa/sounds/thoaban.png");

        // betteekh, hobob, ibra: use the best colored frame in 40-90 range
        processBest("scratch/betekh_frames",
            "assets/images/lessons/baa/sounds/betteekh.png");
        processBest("scratch/hobob_frames",
            "assets/images/lessons/baa/sounds/hobob.png");
        processBest("scratch/ebra2_frames",
            "assets/images/lessons/baa/sounds/ibra.png");

        System.out.println("All done.");
    }

    // Use a specific frame number
    static void processSpecific(String framesDir, int frameNo, String outPath) throws Exception {
        File f = new File(framesDir + "/" + frameNo + ".png");
        if (!f.exists()) {
            System.out.println("[SKIP] Frame not found: " + f);
            return;
        }
        BufferedImage img = ImageIO.read(f);
        crop(img, NAV_BAR_H, outPath, frameNo + ".png");
    }

    // For thoaban: remove nav bar + scene title to hide "الباء الممدود"
    static void processThoaban(String framesDir, int frameNo, String outPath) throws Exception {
        File f = new File(framesDir + "/" + frameNo + ".png");
        if (!f.exists()) { System.out.println("[SKIP] " + f); return; }
        BufferedImage img = ImageIO.read(f);
        // Remove top 96px (36px nav bar + 60px scene title area)
        crop(img, 96, outPath, frameNo + ".png [title-removed]");
    }

    // Find best frame in 40-90 range (most colored pixels)
    static void processBest(String framesDir, String outPath) throws Exception {
        File dir = new File(framesDir);
        if (!dir.exists()) { System.out.println("[SKIP] " + framesDir); return; }
        File[] pngs = dir.listFiles((d, n) -> n.endsWith(".png"));
        if (pngs == null || pngs.length == 0) { System.out.println("[SKIP] empty: " + framesDir); return; }

        java.util.Arrays.sort(pngs, (a, b) ->
            Integer.compare(frameNum(a.getName()), frameNum(b.getName())));

        File best = null; int bestCount = -1;
        for (File png : pngs) {
            int n = frameNum(png.getName());
            if (n < 40 || n > 90) continue;
            BufferedImage img = ImageIO.read(png);
            if (img == null) continue;
            int count = countColoredPixels(img);
            if (count > bestCount) { bestCount = count; best = png; }
        }
        if (best == null) best = pngs[pngs.length / 2];

        BufferedImage img = ImageIO.read(best);
        crop(img, NAV_BAR_H, outPath, best.getName());
    }

    static void crop(BufferedImage img, int topCrop, String outPath, String frameName) throws Exception {
        int w = img.getWidth();
        int h = img.getHeight();
        int cropH = h - topCrop;
        if (cropH <= 0) { System.out.println("[SKIP] crop too large for " + outPath); return; }
        BufferedImage cropped = img.getSubimage(0, topCrop, w, cropH);
        ImageIO.write(cropped, "png", new File(outPath));
        System.out.printf("[OK] %s frame=%s  %dx%d → %dx%d%n",
            new File(outPath).getName(), frameName, w, h, w, cropH);
    }

    static int countColoredPixels(BufferedImage img) {
        int count = 0; int w = img.getWidth(), h = img.getHeight();
        for (int y = 40; y < h - 100; y += 4)
            for (int x = 0; x < w; x += 4) {
                int rgb = img.getRGB(x, y);
                int r=(rgb>>16)&0xFF, g=(rgb>>8)&0xFF, b=rgb&0xFF;
                int max=Math.max(r,Math.max(g,b)), min=Math.min(r,Math.min(g,b));
                if (max - min > 30 && max > 50) count++;
            }
        return count;
    }

    static int frameNum(String name) {
        try { return Integer.parseInt(name.replace(".png","")); }
        catch (NumberFormatException e) { return 0; }
    }
}
