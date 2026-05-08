# 自定义 Issue 与 PR 标签的自动化脚本

为你的仓库提供一套自定义的 Issue 与 PR 标签，替换 GitHub 默认标签体系，让协作流程更统一、更清晰，也更美观。

Provide your repository with a customized Issue and PR label set that is more systematic, easier to maintain, and more visually appealing than GitHub's default labels.

## 功能简介

本仓库当前提供一个 PowerShell 脚本 [`setup_labels.ps1`](setup_labels.ps1)，用于：

- 删除常见 GitHub 默认标签
- 批量创建或更新一套更规范的标签
- 为 Issue 管理、PR 分类、优先级排序和协作状态跟踪提供统一标准

## 标签体系概览

脚本内置的标签主要分为以下几类：

### 1. Size

用于描述改动规模：

- `size:XS`
- `size:S`
- `size:M`
- `size:L`
- `size:XL`
- `size:XXL`

### 2. Priority

用于标记任务优先级：

- `priority/P0`
- `priority/P1`
- `priority/P2`
- `priority/P3`

### 3. Type

用于描述 Issue 或 PR 的性质：

- `type/feat`
- `type/fix`
- `type/docs`
- `type/style`
- `type/refactor`
- `type/perf`
- `type/chore`
- `type/design`
- `type/discussion`

### 4. Status

用于表示当前处理状态：

- `status/wip`
- `status/help-wanted`
- `status/good-first-issue`
- `status/duplicate`
- `status/invalid`
- `status/wont-fix`
- `LGTM`

## 适用场景

这套标签适合以下场景：

- 希望统一多个仓库的标签风格
- 希望区分 Issue 类型、优先级与处理状态
- 希望让 PR 审查流程更加规范
- 希望帮助社区贡献者更快理解任务

## 使用前准备

在运行脚本前，请确保本机已安装并配置：

1. [PowerShell](https://learn.microsoft.com/powershell/)
2. [GitHub CLI](https://cli.github.com/)
3. 已通过 `gh auth login` 完成 GitHub 账号登录
4. 对目标仓库具有标签管理权限

## 使用方法

### 1. 修改目标仓库

打开 [`setup_labels.ps1`](setup_labels.ps1)，找到仓库列表配置：

```powershell
$repos = @(
    "DBJD-CR/astrbot_plugin_awesome_issue_pr_label"
)
```

将其替换为你自己的仓库，例如：

```powershell
$repos = @(
    "your-name/repo-a",
    "your-name/repo-b"
)
```

### 2. 运行脚本

在仓库根目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\setup_labels.ps1
```

脚本会自动：

- 删除预设的默认标签
- 创建不存在的新标签
- 更新已存在标签的颜色与描述

## 注意事项

- 运行脚本后，目标仓库中的部分默认标签会被删除
- 如果你已经有自定义标签，请先检查是否会发生命名冲突
- 可以先在测试仓库中验证效果，再应用到正式仓库
- 若仓库较多，可直接在 [`setup_labels.ps1`](setup_labels.ps1) 中维护批量列表

## 当前仓库内容

- [`README.md`](README.md)：项目说明文档
- [`setup_labels.ps1`](setup_labels.ps1)：标签初始化与同步脚本
- [`LICENSE`](LICENSE)：开源许可证 (MIT)

## 后续可扩展方向

如果后续需要，可以继续补充：

- 标签预览截图
- 中英双语标签说明表
- 针对不同团队的标签模板
- 自动化工作流，例如结合 GitHub Actions 进行检查或同步

## License

See [`LICENSE`](LICENSE).
