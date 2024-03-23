这是一个用来展示如何将 SwiftData 与现代编程理念相结合，顺畅地融入 SwiftUI 应用的演示项目。
详细内容请参阅对应的文章

[SwiftData 实战用现代方法构建 SwiftUI 应用](https://fatbobman.com/zh/posts/practical-swiftdata-building-swiftui-applications-with-modern-approaches/)

> **特别提醒**：自首个版本（iOS 17.0）起，SwiftData 几乎在每个版本中都对一些已知问题进行了修复，同时也可能引入了新的问题。因此，当你运行文章中提供的 Demo 项目，而项目运行在不同的系统版本或使用不同版本的 Xcode 编译时，可能会遇到与预期不一致的结果（比如，点击添加按钮后无法看到新数据，或应用被推到后台时崩溃等）。我们还需等待苹果对这些问题进行进一步的修复。尽管如此，我相信文章中介绍的数据操作逻辑本身是正确的。为了确保在当前项目中以稳定、可靠的方式使用本文介绍的方法，请通过 createDataHandlerWithMainContext 创建所有的 DataHandler（即使用主上下文来构建 DataHandler）。

This is a demonstration project showcasing how to integrate SwiftData with modern programming concepts, seamlessly incorporating it into a SwiftUI application.
For detailed information, please refer to the corresponding article.

[Practical SwiftData: Building SwiftUI Applications with Modern Approaches](https://fatbobman.com/en/posts/practical-swiftdata-building-swiftui-applications-with-modern-approaches/)

> **Special Reminder**: Since its first version (iOS 17.0), SwiftData has been fixing some known issues in almost every version, but new problems might also be introduced. Therefore, when you run the demo project provided in the article, and the project is running on different system versions or compiled with different versions of Xcode, you might encounter results that are inconsistent with expectations (for example, not being able to see new data after clicking the add button, or the app crashes when pushed to the background, etc.). We still need to wait for Apple to further address these issues. Nevertheless, I believe the data manipulation logic introduced in the article is correct. To ensure the method introduced in this article is used in a stable and reliable manner in the current project, please create all `DataHandler`s through `createDataHandlerWithMainContext` (i.e., building `DataHandler` with the main context).
