# ================= 配置区域 =================
# 您的仓库列表 (请根据实际情况修改)
$repos = @(
    "DBJD-CR/awesome_issue_pr_label"
)

# 1. 要删除的默认标签 (GitHub 原厂标签)
$labels_to_delete = @(
    "bug", "enhancement", "documentation", "duplicate", 
    "good first issue", "help wanted", "invalid", "question", "wontfix"
)

# 2. 要创建/更新的新标签 (我们的完美体系)
$labels_to_create = @(
    # --- 1. 规模标签 (Size - 适配 Dosu 使用冒号) ---
    @{name="size:XS"; color="3CBF00"; desc="修改了 0-9 行代码 (忽略生成文件)"},
    @{name="size:S";  color="5D9801"; desc="修改了 10-29 行代码 (忽略生成文件)"},
    @{name="size:M";  color="BFD4F2"; desc="修改了 30-99 行代码 (忽略生成文件)"},
    @{name="size:L";  color="FBCA04"; desc="修改了 100-499 行代码 (忽略生成文件)"},
    @{name="size:XL"; color="D93F0B"; desc="修改了 500-999 行代码 (忽略生成文件)"},
    @{name="size:XXL";color="B60205"; desc="修改了 1000+ 行代码 (忽略生成文件)"},

    # --- 2. 优先级标签 (Priority - P0~P3) ---
    @{name="priority/P0"; color="B60205"; desc="最高优先级：核心功能崩溃或严重阻碍使用，必须立即修复"},
    @{name="priority/P1"; color="D93F0B"; desc="高优先级：重要功能缺陷或关键需求，需尽快处理"},
    @{name="priority/P2"; color="FBCA04"; desc="中优先级：普通功能缺陷或改进，按计划排期"},
    @{name="priority/P3"; color="C2E0C6"; desc="低优先级：边缘问题、微小体验优化或不紧急的建议"},

    # --- 3. 类型标签 (Type) ---
    @{name="type/feat";       color="A2EEEF"; desc="✨ 新功能 / New Feature"},
    @{name="type/fix";        color="D73A4A"; desc="🐛 Bug 修复"},
    @{name="type/docs";       color="0075CA"; desc="📚 文档变更"},
    @{name="type/style";      color="FFD76E"; desc="💄 代码格式、UI 样式调整 (不影响逻辑)"},
    @{name="type/refactor";   color="F29B8F"; desc="♻️ 代码重构 (无功能变化)"},
    @{name="type/perf";       color="5319E7"; desc="⚡ 性能优化"},
    @{name="type/chore";      color="C5DEF5"; desc="🔧 杂项、构建流程、依赖更新"},
    @{name="type/design";     color="ff74d1"; desc="🎨 交互设计、UI/UX 方案讨论"}, # 亮粉色
    @{name="type/discussion"; color="006b75"; desc="💬 开放性讨论、头脑风暴或非代码类话题"},

    # --- 4. 状态标签 (Status) ---
    @{name="status/wip";              color="3FB58E"; desc="🚧 施工中 / Do Not Merge"},
    @{name="status/help-wanted";      color="008672"; desc="🙋‍ 需要社区帮助"},
    @{name="status/good-first-issue"; color="7057ff"; desc="👋 适合新人关注 - 了解项目动态或尝试简单参与"},
    @{name="status/duplicate";        color="CFD3D7"; desc="👯‍ 重复的问题或 PR"},
    @{name="status/invalid";          color="E4E669"; desc="🚫 无效或无法复现"},
    @{name="status/wont-fix";         color="FFFFFF"; desc="❌ 不予修复或采纳"},
    @{name="LGTM";                    color="0E8A16"; desc="✅ Looks Good To Me - 代码审查通过，准备合并"}
)

# ================= 执行区域 =================

foreach ($repo in $repos) {
    Write-Host "正在处理仓库: $repo ..." -ForegroundColor Cyan
    
    # 1. 清理旧标签
    Write-Host "  -> 正在清理默认标签..." -NoNewline
    foreach ($l in $labels_to_delete) {
        # 2>&1 | Out-Null 用于屏蔽报错（如果标签本来就不存在）
        gh label delete "$l" --repo $repo --yes 2>&1 | Out-Null
    }
    Write-Host " [完成]" -ForegroundColor Green

    # 2. 创建/更新新标签
    foreach ($label in $labels_to_create) {
        $name = $label.name
        $color = $label.color
        $desc = $label.desc

        Write-Host "  -> 正在应用标签: $name" -NoNewline
        
        try {
            # 尝试创建
            $null = gh label create "$name" --repo "$repo" --color "$color" --description "$desc" 2>&1
            Write-Host " [创建成功]" -ForegroundColor Green
        }
        catch {
            # 如果创建失败（通常是因为已存在），则尝试更新
            try {
                $null = gh label edit "$name" --repo "$repo" --color "$color" --description "$desc" 2>&1
                Write-Host " [更新成功]" -ForegroundColor Yellow
            }
            catch {
                Write-Host " [失败]" -ForegroundColor Red
                Write-Host $_.Exception.Message
            }
        }
    }
    Write-Host "仓库 $repo 处理完毕!`n" -ForegroundColor Cyan
}

Write-Host "所有任务执行完成！将军，请检阅！" -ForegroundColor Magenta
Read-Host "按回车键退出..."
