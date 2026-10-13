import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class PatchBackgrounds {
    public static void main(String[] args) throws Exception {
        File bgFile = new File("assets/images/lessons/baa/baa_sounds.jpg");
        File bgMaddFile = new File("assets/images/lessons/baa/baa_madd.jpg");
        File boardFile = new File("scratch/bakra1_shapes_png/28.png");

        if (!bgFile.exists() || !boardFile.exists()) {
            System.out.println("Files not found: " + bgFile.exists() + ", " + boardFile.exists());
            return;
        }

        BufferedImage bg = ImageIO.read(bgFile);
        BufferedImage bgMadd = ImageIO.read(bgMaddFile);
        BufferedImage board = ImageIO.read(boardFile);

        System.out.println("BG size: " + bg.getWidth() + "x" + bg.getHeight());
        System.out.println("Board size: " + board.getWidth() + "x" + board.getHeight());

        // Let's find the best alignment (x, y) where the rope/vines match
        // The board is on the right side: x between 550 and 650, y between 0 and 60
        int bestX = 584;
        int bestY = 0;
        long minDiff = Long.MAX_VALUE;

        // Sample non-transparent pixels from board edges (e.g. the rope)
        for (int x = 570; x <= 620; x++) {
            for (int y = 0; y <= 50; y++) {
                long diff = 0;
                int count = 0;
                // sample rope points: x=15 to 25 (left rope), y=20 to 60
                for (int bx = 15; bx <= 25; bx++) {
                    for (int by = 20; by <= 60; by++) {
                        int boardPixel = board.getRGB(bx, by);
                        int alpha = (boardPixel >> 24) & 0xff;
                        if (alpha > 200) {
                            int bgX = x + bx;
                            int bgY = y + by;
                            if (bgX < bg.getWidth() && bgY < bg.getHeight()) {
                                int bgPixel = bg.getRGB(bgX, bgY);
                                int r1 = (boardPixel >> 16) & 0xff;
                                int g1 = (boardPixel >> 8) & 0xff;
                                int b1 = boardPixel & 0xff;
                                int r2 = (bgPixel >> 16) & 0xff;
                                int g2 = (bgPixel >> 8) & 0xff;
                                int b2 = bgPixel & 0xff;
                                diff += Math.abs(r1 - r2) + Math.abs(g1 - g2) + Math.abs(b1 - b2);
                                count++;
                            }
                        }
                    }
                }
                if (count > 0 && diff < minDiff) {
                    minDiff = diff;
                    bestX = x;
                    bestY = y;
                }
            }
        }

        System.out.println("Best alignment: x=" + bestX + ", y=" + bestY + ", minDiff=" + minDiff);

        // Apply board onto baa_sounds.jpg
        Graphics2D g1 = bg.createGraphics();
        g1.drawImage(board, bestX, bestY, null);
        g1.dispose();
        ImageIO.write(bg, "jpg", new File("assets/images/lessons/baa/baa_sounds.jpg"));

        // Apply board onto baa_madd.jpg
        Graphics2D g2 = bgMadd.createGraphics();
        g2.drawImage(board, bestX, bestY, null);
        g2.dispose();
        ImageIO.write(bgMadd, "jpg", new File("assets/images/lessons/baa/baa_madd.jpg"));

        System.out.println("Successfully patched baa_sounds.jpg and baa_madd.jpg!");
    }
}
