import org.junit.Test;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import static org.junit.Assert.assertEquals;

public class PrometheusContainerShould extends ContainerTestBase {
    @Test
    public void listenOnWebUiPort() throws IOException {
        URL root = new URL(String.format("http://%s:%d",
                getContainer().getContainerIpAddress(),
                getContainer().getMappedPort(9090)));

        HttpURLConnection connection = (HttpURLConnection)root.openConnection();
        connection.connect();

        assertEquals(200,  connection.getResponseCode());
    }
}