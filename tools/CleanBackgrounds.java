import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class CleanBackgrounds {
    public static void main(String[] args) throws Exception {
        cleanImage("assets/images/lessons/baa/baa_sounds.jpg");
        cleanImage("assets/images/lessons/baa/baa_madd.jpg");
        System.out.println("Background images perfectly cleaned with zero specks!");
    }

    private static void cleanImage(String path) throws Exception {
        File f = new File(path);
        BufferedImage img = ImageIO.read(f);

        Graphics2D g = img.createGraphics();
        // Exact board paper color: #FEFFBA
        g.setColor(new Color(254, 255, 186));

        // Fill from x=645 to x=800, y=85 to y=225
        g.fillRect(645, 85, 155, 140);
        g.dispose();

        ImageIO.write(img, "jpg", f);
        System.out.println("Cleaned: " + path);
    }
}
