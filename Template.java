import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Template {

    // debug() メソッドの出力のON/OFF
    boolean isDebugEnabled = true;

    // データをファイルから読むかのON/OFF
    boolean isReadFromFile = true;

    // ↑がtrueのときは↓このファイルからデータを読み込む
    String dataFileName = "hoge.txt";

    public static void main(String[] args) throws Exception {
        new Template().exec(args);
    }

    /**
     * メイン処理。
     *
     * @param args コマンドライン引数
     * @throws Exception 何か問題が発生したとき
     */
    public void exec(String[] args) throws Exception {
        List<String> lines = null;
        if (isReadFromFile) {
            lines = readLinesFromFile();
        } else {
            lines = readLines();
        }
        log("input lines: " + lines);

        // ここからメインの処理

        // 全部数値の入力の場合はこれでInteger化しておけばOK
        // List<List<Integer>> inputValues = linesToListOfIntegerList(lines);
    }

    public void print(Object o) {
        System.out.println(o);
    }

    public void log(Object o) {
        if (isDebugEnabled) {
            System.out.println(o);
        }
    }

    public List<List<Integer>> linesToListOfIntegerList(List<String> lines) {
        return lines.stream().map(this::lineToIntList).collect(Collectors.toList());
    }

    public List<List<String>> linesToListOfStringList(List<String> lines) {
        return lines.stream().map(line -> Arrays.asList(line.split(" "))).collect(Collectors.toList());
    }

    public List<Integer> lineToIntList(String line) {
        return Arrays.stream(line.split(" ")).map(Integer::valueOf).collect(Collectors.toList());
    }

    public List<String> readLines() throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        List<String> result = br.lines().collect(Collectors.toList());
        return result;
    }

    /**
     * ローカル開発用。
     * テストしやすいように、本番ならば標準入力から受け取るはずのデータを
     * ファイルに保存しておいて、そこから読み込むために使う。
     *
     * @return 1行ずつを要素に持つ文字列のリスト
     * @throws IOException なにかIOで問題が発生したとき
     */
    public List<String> readLinesFromFile() throws IOException {
        return Files.readAllLines(Paths.get(dataFileName));
    }
}
