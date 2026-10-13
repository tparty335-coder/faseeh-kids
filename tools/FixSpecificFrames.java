import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;

/**
 * FixSpecificFrames.java
 * Applies the correct frame + crop for ibra, hobob, thoaban.
 * - ibra:    frame 130 from ebra2_frames (shows needle in hollow, "أصوات الحرف" title), remove top 36px
 * - hobob:   frame 80 from hobob_frames (shows seeds in hollow, "الباء الممدود" title), remove top 96px
 * - thoaban: frame 100 from thoaban_frames (shows snake in hollow, "الباء الممدود" title), remove top 96px
 */
public class FixSpecificFrames {

    public static void main(String[] args) throws Exception {
        cropFrame("scratch/ebra2_frames/130.png",
                  36,
                  "assets/images/lessons/baa/sounds/ibra.png",
                  "ibra (needle, frame 130)");

        cropFrame("scratch/hobob_frames/80.png",
                  96,
                  "assets/images/lessons/baa/sounds/hobob.png",
                  "hobob (seeds, frame 80, title removed)");

        cropFrame("scratch/thoaban_frames/100.png",
                  96,
                  "assets/images/lessons/baa/sounds/thoaban.png",
                  "thoaban (snake, frame 100, title removed)");

        System.out.println("Done.");
    }

    static void cropFrame(String src, int topCrop, String dst, String label) throws Exception {
        File f = new File(src);
        if (!f.exists()) {
            System.out.println("[MISSING] " + src);
            return;
        }
        BufferedImage img = ImageIO.read(f);
        int w = img.getWidth(), h = img.getHeight();
        int newH = h - topCrop;
        if (newH <= 0) { System.out.println("[SKIP too large] " + label); return; }

        BufferedImage cropped = img.getSubimage(0, topCrop, w, newH);
        ImageIO.write(cropped, "png", new File(dst));
        System.out.printf("[OK] %-40s  %dx%d → %dx%d%n", label, w, h, w, newH);
    }
}
