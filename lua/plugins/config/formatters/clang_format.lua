-- 将table转换为字符串的函数
local function tableToString(tbl)
    local result = {}
    for k, v in pairs(tbl) do
        table.insert(result, k)
        -- 如果值是字符串，则加上引号，否则直接转换为字符串
        if type(v) == "string" then
            table.insert(result, v)
        else
            table.insert(result, tostring(v))
        end
    end

    return result
end

local styles = {
    AlignOperands = "Align",
    AllowAllArgumentsOnNextLine = false,
    AllowAllConstructorInitializersOnNextLine = false,
    AllowAllParametersOfDeclarationOnNextLine = false,
    AllowShortBlocksOnASingleLine = "Always",
    AllowShortCaseLabelsOnASingleLine = false,
    AllowShortFunctionsOnASingleLine = "All",
    AllowShortIfStatementsOnASingleLine = "Always",
    AllowShortLambdasOnASingleLine = "All",
    AllowShortLoopsOnASingleLine = true,
    AlwaysBreakAfterReturnType = "None",
    AlwaysBreakTemplateDeclarations = "Yes",
    BreakBeforeBraces = "Custom",
    -- BraceWrapping = {
    -- AfterCaseLabel = false,
    -- AfterClass = false,
    -- AfterControlStatement = "Never",
    -- AfterEnum = false,
    -- AfterFunction = false,
    -- AfterNamespace = false,
    -- AfterUnion = false,
    -- BeforeCatch = false,
    -- BeforeElse = false,
    -- IndentBraces = false,
    -- SplitEmptyFunction = false,
    -- SplitEmptyRecord = true
    -- },
    BreakBeforeBinaryOperators = "None",
    BreakBeforeTernaryOperators = true,
    BreakConstructorInitializers = "BeforeColon",
    BreakInheritanceList = "BeforeColon",
    ColumnLimit = 120,
    CompactNamespaces = false,
    ContinuationIndentWidth = 8,
    IndentCaseLabels = true,
    IndentPPDirectives = "None",
    IndentWidth = 4,
    KeepEmptyLinesAtTheStartOfBlocks = "true",
    MaxEmptyLinesToKeep = 2,
    NamespaceIndentation = "All",
    ObjCSpaceAfterProperty = false,
    ObjCSpaceBeforeProtocolList = true,
    PointerAlignment = "Right",
    ReflowComments = false,
    SpaceAfterCStyleCast = true,
    SpaceAfterLogicalNot = false,
    SpaceAfterTemplateKeyword = false,
    SpaceBeforeAssignmentOperators = true,
    SpaceBeforeCpp11BracedList = false,
    SpaceBeforeCtorInitializerColon = true,
    SpaceBeforeInheritanceColon = true,
    SpaceBeforeParens = "ControlStatements",
    SpaceBeforeRangeBasedForLoopColon = false,
    SpaceInEmptyParentheses = false,
    SpacesBeforeTrailingComments = 0,
    SpacesInAngles = false,
    SpacesInCStyleCastParentheses = false,
    SpacesInContainerLiterals = false,
    SpacesInParentheses = false,
    SpacesInSquareBrackets = false,
    TabWidth = 4,
    UseTab = "Never",
}

return tableToString(styles)
