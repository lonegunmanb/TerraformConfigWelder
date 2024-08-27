package acctest_test

import (
	"github.com/stretchr/testify/assert"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"testing"

	"github.com/stretchr/testify/require"
)

var testFolders = []string{
	filepath.Join("azurerm", "v3_v4"),
}

func Test_Transform(t *testing.T) {
	for _, testFolder := range testFolders {
		absTestFolder := filepath.Join("..", testFolder)
		absTfDir := filepath.Join(absTestFolder, "test-fitness")
		var err error
		absTestFolder, err = filepath.Abs(filepath.Clean(absTestFolder))
		require.NoError(t, err)
		absTfDir, err = filepath.Abs(filepath.Clean(absTfDir))
		require.NoError(t, err)
		transformCmd := exec.Command("mapotf", "transform", "--mptf-dir", absTestFolder, "--tf-dir", absTfDir)
		transformCmd.Dir = absTestFolder
		defer func() {
			resetCmd := exec.Command("mapotf", "reset", "--tf-dir", absTfDir)
			resetCmd.Dir = absTestFolder
			resetCmd.Stdout = os.Stdout
			resetCmd.Stderr = os.Stderr
			resetCmd.Stdin = os.Stdin
			_ = resetCmd.Run()
		}()
		transformCmd.Stdout = os.Stdout
		transformCmd.Stderr = os.Stderr
		transformCmd.Stdin = os.Stdin
		require.NoError(t, transformCmd.Run())
		avmFixCmd := exec.Command("avmfix", "-folder", absTfDir)
		require.NoError(t, avmFixCmd.Run())
		tfDirFiles, err := os.ReadDir(absTfDir)
		require.NoError(t, err)
		for _, f := range tfDirFiles {
			if f.IsDir() {
				continue
			}
			if !strings.HasSuffix(f.Name(), ".wanted.hcl") {
				continue
			}
			t.Run(filepath.Join(testFolder, f.Name()), func(t *testing.T) {
				expected, err := os.ReadFile(filepath.Join(absTfDir, f.Name()))
				require.NoError(t, err)
				actual, err := os.ReadFile(filepath.Join(absTfDir, strings.TrimSuffix(f.Name(), ".wanted.hcl")+".tf"))
				require.NoError(t, err)
				assert.Equal(t, strings.ReplaceAll(string(expected), "\r", ""), strings.ReplaceAll(string(actual), "\r", ""))
			})
		}
	}
}
