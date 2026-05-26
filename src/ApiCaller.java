import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * ApiCaller - Java 8 compatible.
 * Fetches a random joke from the public JokeAPI.
 * Called directly from Jython via the JVM bridge.
 */
public class ApiCaller {

    private static final Logger LOGGER = Logger.getLogger(ApiCaller.class.getName());
    private static final String API_URL = "https://official-joke-api.appspot.com/random_joke";
    private static final int TIMEOUT_MS = 5000;

    /**
     * Fetches a random joke from the JokeAPI.
     *
     * @return raw JSON string
     * @throws IOException if the connection or read fails
     */
    public static String fetchRandomJoke() throws IOException {
        HttpURLConnection conn = null;
        try {
            URL url = new URL(API_URL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            conn.setConnectTimeout(TIMEOUT_MS);
            conn.setReadTimeout(TIMEOUT_MS);

            int status = conn.getResponseCode();
            if (status != HttpURLConnection.HTTP_OK) {
                throw new IOException("API call failed with HTTP status: " + status);
            }

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            return response.toString();

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    /**
     * Extracts setup and punchline from the raw JSON response.
     * Pure Java 8 - no external JSON libraries required.
     *
     * @param json raw JSON string from the API
     * @return formatted joke string
     */
    public static String parseJoke(String json) {
        String setup = extractValue(json, "setup");
        String punchline = extractValue(json, "punchline");
        if (setup != null && punchline != null) {
            return "Setup:     " + setup + "\nPunchline: " + punchline;
        }
        LOGGER.log(Level.WARNING, "Could not parse joke from response: {0}", json);
        return "(Could not parse joke) Raw: " + json;
    }

    /**
     * Extracts a string value from a simple JSON object by key.
     * Handles basic escaped characters.
     */
    private static String extractValue(String json, String key) {
        String search = "\"" + key + "\":\"";
        int start = json.indexOf(search);
        if (start == -1) {
            return null;
        }
        start += search.length();
        int end = json.indexOf("\"", start);
        if (end == -1) {
            return null;
        }
        return json.substring(start, end);
    }
}
