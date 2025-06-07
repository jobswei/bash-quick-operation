# ======== 有root权限 ============
sudo apt update
sudo apt install zsh -y
# 将Zsh设置为默认Shell
chsh -s /usr/bin/zsh
zsh

y | sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh
# y | bash install.sh

zsh

export PIPENV_PYPI_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple
alias pip=pip3
alias python=python3

git clone git@github.com:zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# git clone https://gitee.com/mirror-luyi/zsh-autosuggestions.git ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
# git clone https://gitee.com/mirror-luyi/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
# git clone --depth=1 https://gitee.com/ylx252/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 定义要设置的插件列表
PLUGINS_CONFIG='plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    z
)'

# 检查是否存在plugins配置
if grep -q '^plugins=(' ~/.zshrc; then
    # 存在则替换整个plugins块
    # 使用awk处理多行替换
    awk -v plugins_config="$PLUGINS_CONFIG" '
    BEGIN {in_plugins=0}
    /^plugins=\(/ {in_plugins=1; print plugins_config; next}
    in_plugins && /\)/ {in_plugins=0; next}
    !in_plugins {print}
    ' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc
else
    # 不存在则追加
    echo "$PLUGINS_CONFIG" >> ~/.zshrc
fi

# 检查是否存在ZSH_THEME字段
if grep -q '^ZSH_THEME=' ~/.zshrc; then
  # 存在则替换
  sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
else
  # 不存在则追加
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
fi

source ~/.zshrc
