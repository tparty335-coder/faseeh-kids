import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class AnalyzeBoard {
    public static void main(String[] args) throws Exception {
        BufferedImage img = ImageIO.read(new File("assets/images/lessons/baa/baa_madd.jpg"));
        for (int y = 70; y <= 250; y += 15) {
            int rgb = img.getRGB(680, y);
            System.out.printf("y=%d: #%06X (R=%d, G=%d, B=%d)\n", y, (rgb & 0xffffff), (rgb >> 16) & 0xff, (rgb >> 8) & 0xff, rgb & 0xff);
        }
    }
}
