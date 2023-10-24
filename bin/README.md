# bin

## MArchiveBatchTool

The precompiled binary files provided were compiled on Fedora 38 on an x86-64.
The build script used was:

```sh
$ sudo dnf -y copr enable @dotnet-sig/dotnet
$ sudo dnf -y install dotnet-sdk-6.0
$ git clone https://github.com/masible/marchive-batch-tool.git
$ cd marchive-batch-tool
$ dotnet publish -c Release -r linux-x64 --self-contained true MArchiveBatchTool.sln
```

The resulting binaries will be in `MArchiveBatchTool/bin/Release/netcoreapp2.2/linux-x64/publish`.
