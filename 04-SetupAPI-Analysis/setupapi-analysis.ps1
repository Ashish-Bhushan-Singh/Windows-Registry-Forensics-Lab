
# SetupAPI Device Installation Analysis

$log = "C:\Windows\INF\setupapi.dev.log"

$identifiers = @(
    "03025016032221104412",
    "4C530000070714121483"
)

Select-String -Path $log `
    -Pattern $identifiers `
    -Context 3,5
