export class TextUtils {
  // json 字符串转为为 url编码的键值对字符串
  static jsonToUrlEncodedString(jsonString: string): string {
    console.log(`jsonString = ${jsonString}`)
    let json: Record<string, string>;

    try {
      json = JSON.parse(jsonString);
    } catch (error) {
      throw new Error("Invalid JSON string");
    }

    let result: string = Object.keys(json)
      .map(key => {
        const value = encodeURIComponent(json[key]);
        return `${encodeURIComponent(key)}=${value}`;
      })
      .join('&');
    console.log(`键值对: ${result}`)
    return result
  }

  // map 键值对转为为 url编码的键值对字符串
  static mapToUrlEncodedString(map: Record<string, string | number | boolean>): string {
    // 将 Map 转换为数组，并对每个键值对进行 URI 编码
    const paramsArray = Object.keys(map).map((key) => {
      return encodeURIComponent(key) + '=' + encodeURIComponent(map[key]);
    });
    // 将数组用 `&` 拼接成 URL encoded 字符串
    let result: string = paramsArray.join('&');
    return result;
  }

  // 参考 `android.text.TextUtils.htmlEncode`
  static htmlEncode(str: string): string {
    return str.replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll("&", "&amp;")
      .replaceAll("'", "&#39;")
      .replaceAll("\"", "&quot;")
  }

  // 参考 `android.text.TextUtils.htmlEncode`
  static htmlDecode(str: string): string {
    return str.replaceAll("&lt;", "<")
      .replaceAll("&gt;", ">")
      .replaceAll("&amp;", "&")
      .replaceAll("&#39;", "'")
      .replaceAll("&apos;", "'")// 兼容 &apos;
      .replaceAll("&quot;", "\"")//
        //
      .replaceAll("&ldquo;", "“")// U+201C
      .replaceAll("&rdquo;", "”")// U+201D
      .replaceAll("&lsquo;", "‘")// U+2018
      .replaceAll("&rsquo;", "’")// U+2019
        //
      .replaceAll("&mdash;", "—") // U+2014
  }
}