
一个机器学习的小案例

数据集与来自kaggle上的经典竞赛Titanic，该数据集共1309条数据，其中实验数据891条，预测数据418条；实验数据比预测数据多了一列：即标签"result"。

PassengerId 整型变量，标识乘客的ID，递增变量，对预测无帮助
Survived 整型变量，标识该乘客是否幸存。0表示遇难，1表示幸存。将其转换为factor变量比较方便处理
Pclass 整型变量，标识乘客的社会-经济状态，1代表Upper，2代表Middle，3代表Lower
Name 字符型变量，除包含姓和名以外，还包含Mr. Mrs. Dr.这样的具有西方文化特点的信息
Sex 字符型变量，标识乘客性别，适合转换为factor类型变量
Age 整型变量，标识乘客年龄，有缺失值
SibSp 整型变量，代表兄弟姐妹及配偶的个数。其中Sib代表Sibling也即兄弟姐妹，Sp代表Spouse也即配偶
Parch 整型变量，代表父母或子女的个数。其中Par代表Parent也即父母，Ch代表Child也即子女
Ticket 字符型变量，代表乘客的船票号
Fare 数值型，代表乘客的船票价
Cabin 字符型，代表乘客所在的舱位，有缺失值
Embarked 字符型，代表乘客登船口岸，适合转换为factor型变量

案例中使用的机器学习方法有：SVC、决策树、随机森林、KNN、LR、Gradient Boosting Classifier、极端随机树等