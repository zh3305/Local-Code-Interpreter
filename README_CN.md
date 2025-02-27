**Read in other language: [English](README.md)**

# 本地代码解释器
OpenAI的ChatGPT代码解释器（Code Interpreter或Advanced Data Analysis）的本地版。

## 简介

OpenAI的ChatGPT代码解释器（Code Interpreter，现更名为Advanced Data Analysis）是一款强大的AI工具。然而，其在在线沙箱环境中运行代码的特性导致了一些限制，如包的缺失、上传速度较慢、仅支持上传不超过100MB的文件以及代码最多只能运行120秒等。为此，我们推出了本地代码解释器（Local Code Interpreter）。这款工具允许您在自己的设备上，利用自己专属的Python环境来执行ChatGPT生成的代码，从而解除了原有解释器的各种限制。

## 优势

- **自定义环境**：在您本地环境中运行代码，确保各种依赖都已正确安装。

- **无缝体验**：告别100MB文件大小限制和网速问题。使用本地版代码解释器，一切尽在掌控之中。

- **可用GPT-3.5**：官方代码解释器只能在GPT-4中使用，但现在你甚至可以在一轮对话中自由切换GPT-3.5和GPT-4。

- **数据更安全**：代码在本地运行，无需将文件上传至网络，提高了数据的安全性。

- **[open-interpreter](https://github.com/KillianLucas/open-interpreter/tree/main)**：相对于open-interpreter有更小的Token使用量,在GPT-3.5模型下有更好的效果.

## 注意事项
在您自己的设备上执行AI生成但未经人工审核的代码可能存在安全风险。在运行此程序前，您应当采用一些安全措施，例如使用虚拟机，以保护您的设备和数据。使用此程序所产生的所有后果，您需自行承担。

## 使用方法

### 在Docker中运行

#### 直接运行

```bash
docker run -it --rm   -e OPENAI_API_KEY=youOpenApiKey -p 7860:7860 zh3305/localcodeinterpreter:latest
```

##### 环境变量

### `OPENAI_API_KEY`

API密钥

### `INTERPETER_API_TYPE`

默认为 `open_ai`

### `INTERPETER_API_BASE`

Api访问地址,默认为 `https://api.openai.com/v1` ,可使用反向代理地址,如ChatGPT Next Web提供的代理接口地址 `https://chatgpt2.nextweb.fun/api/proxy/v1`

### `INTERPETER_API_VERSION`

如果您使用Azure OpenAI服务，请在`设置为`2023-07-01-preview`，其他API版本不支持函数调用。

### `http_proxy`, `https_proxy`

代理服务器地址,可设置访问的代理服务器 如: -e http_proxy=http://192.168.1.10:11992 `http代理地址` -e https_proxy=http://192.168.1.10:11992 `https代理地址`



#### 手动编译Docker镜像

```bash
docker build --pull --rm -f "Dockerfile" -t localcodeinterpreter:latest "." 
```



### 手动部署

#### 安装

1. 克隆本仓库
   ```shell
   git clone https://github.com/MrGreyfun/Local-Code-Interpreter.git
   cd Local-Code-Interpreter
   ```

2. 安装依赖。该程序已在Windows 10和CentOS Linux 7.8上使用Python 3.9.16测试。所需的库及版本：
   ```text 
   Jupyter Notebook    6.5.4
   gradio              3.39.0
   openai              0.27.8
   ```
   其他系统或库版本也可能有效。
   您可以使用以下命令直接安装所需的软件包：
   
   ```shell
   pip install -r requirements.txt
   ```
   如果您不熟悉Python，可以使用以下命令安装，它将额外安装常用的Python数据分析库：
   ```shell
   pip install -r requirements_full.txt
   ```
#### 配置

1. 在`src`目录中创建一个`config.json`文件，参照`config_example`目录中提供的示例进行配置。

2. 在`config.json`文件中配置您的API密钥。

请注意：
1. **正确设置`model_name`**
    该程序依赖于`0163`版本的模型的函数调用能力，这些模型包括：
    - `gpt-3.5-turbo-0613` (及其16K版本)
    - `gpt-4-0613` (及其32K版本)

    旧版本的模型将无法使用。

    对于使用Azure OpenAI的用户：
    - 请将`model_name`设置为您的模型的部署名（deployment name）。
    - 确认部署的模型是`0613`版本。

2. **API版本设置**
    如果您使用Azure OpenAI服务，请在`config.json`文件中将`API_VERSION`设置为`2023-07-01-preview`，其他API版本不支持函数调用。

3. **使用环境变量配置密钥**
    如果您不希望将API密钥存储在`config.json`文件中，可以选择通过环境变量来设置密钥：
    - 将`config.json`文件中的`API_KEY`设为空字符串：
        ```json
        "API_KEY": ""
        ```
    - 在运行程序之前，使用您的API密钥设置环境变量`OPENAI_API_KEY`：
        - Windows：
        ```shell
        set OPENAI_API_KEY=<你的API密钥>
        ```
        - Linux：
        ```shell
        export OPENAI_API_KEY=<你的API密钥>
        ```

#### 运行

1. 进入`src`目录。
   ```shell
   cd src
   ```

2. 运行以下命令：
   ```shell
   python web_ui.py
   ```

3. 在浏览器中访问终端生成的链接，开始使用本地版代码解释器。

## 示例

以下是一个使用本程序进行线性回归任务的示例：

1. 上传数据文件并要求模型对数据进行线性回归：
   ![Example 1](example_img/1.jpg)

2. 生成的代码执行中遇到错误：
   ![Example 2](example_img/2.jpg)

3. ChatGPT自动检查数据格式并修复bug：
   ![Example 3](example_img/3.jpg)

4. 修复bug后的代码成功运行：
   ![Example 4](example_img/4.jpg)

5. 最终结果符合要求：
   ![Example 5](example_img/5.jpg)
   ![Example 6](example_img/6.jpg)
