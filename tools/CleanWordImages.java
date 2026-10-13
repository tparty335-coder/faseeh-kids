import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;

/**
 * CleanWordImages.java
 * Removes the embedded word text from the bottom of each Baa sounds image.
 * Scans upward from the bottom to find where the gap between text and illustration is.
 * The gap is a mostly-white horizontal band separating the illustration from the word text.
 */
public class CleanWordImages {

    public static void main(String[] args) throws Exception {
        String[] images = {
            "assets/images/lessons/baa/sounds/baqara.png",
            "assets/images/lessons/baa/sounds/thoaban.png",
            "assets/images/lessons/baa/sounds/betteekh.png",
            "assets/images/lessons/baa/sounds/ibra.png",
            "assets/images/lessons/baa/sounds/hobob.png",
            "assets/images/lessons/baa/sounds/borg.png",
        };

        for (String path : images) {
            cleanImage(path);
        }
        System.out.println("Done.");
    }

    static void cleanImage(String path) throws Exception {
        BufferedImage img = ImageIO.read(new File(path));
        int w = img.getWidth();
        int h = img.getHeight();

        // Scan from bottom upward to find the "gap" row
        // A gap row = >90% of pixels are white/near-white (RGB each > 240)
        int cropY = findGapRow(img, w, h);

        if (cropY <= 0 || cropY >= h) {
            System.out.println("  [SKIP] No gap found: " + path);
            return;
        }

        // Crop: keep only the rows above the gap
        BufferedImage cropped = img.getSubimage(0, 0, w, cropY);

        // Save back as PNG
        ImageIO.write(cropped, "png", new File(path));
        System.out.printf("  [OK] %s  %dx%d → %dx%d%n",
            new File(path).getName(), w, h, w, cropY);
    }

    /**
     * Finds the topmost row of the "gap" region between illustration and text.
     * The gap is the highest (smallest y) all-white row in the bottom 45% of the image.
     * If no gap found, returns h (don't crop).
     */
    static int findGapRow(BufferedImage img, int w, int h) {
        // Only search in the bottom 45% of the image
        int searchStart = (int)(h * 0.55);

        // Scan from searchStart downward to find the first mostly-white row
        for (int y = searchStart; y < h; y++) {
            if (isWhiteRow(img, y, w)) {
                // Found start of gap — now scan upward to find the topmost white row
                // of this contiguous white band
                int gapTop = y;
                while (gapTop > searchStart && isWhiteRow(img, gapTop - 1, w)) {
                    gapTop--;
                }
                return gapTop;
            }
        }
        return h; // no gap found
    }

    static boolean isWhiteRow(BufferedImage img, int y, int w) {
        int threshold = 240;
        int nonWhite = 0;
        for (int x = 0; x < w; x++) {
            int rgb = img.getRGB(x, y);
            int r = (rgb >> 16) & 0xFF;
            int g = (rgb >> 8) & 0xFF;
            int b = rgb & 0xFF;
            if (r < threshold || g < threshold || b < threshold) {
                nonWhite++;
            }
        }
        // Row is "white" if >92% of pixels are near-white
        return nonWhite < (w * 0.08);
    }
}
