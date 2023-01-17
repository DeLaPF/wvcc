if exist dev\target (
    cd dev\target
    if exist mingwBuild.bat (
        echo "Found 'mingwBuild.bat'"
        .\mingwBuild.bat
    ) else echo "'mingwBuild.bat' file missing"
) else echo "'target' dir missing"

