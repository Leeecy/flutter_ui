
class Fraction {
  num a;
  num b;

  Fraction(num a, num b):a = a,b = b {
    if (b == 0) {
      throw "分母不能为0!";
    } else if (a == null || b == null) {
      throw "不能为null!";
    }

  }

  Fraction operator +(Fraction other) {
    return new Fraction(a * other.b + b*other.a, b * other.b);
  }

  Fraction operator *(Fraction other) {
    return new Fraction(a * other.a, b * other.b);
  }


  @override
  String toString() {
    if (a == 0) {
      return '0';
    } else if (a == b) {
      return '1';
    } else if(a.abs() == b.abs()){
      return '-1';
    } else {
      //x:较大 y：较小
      num temp;
      num x = a;
      num y = b;
      if (x < y) {
        temp = x;
        x = y;
        y = temp;
      }
      temp = _gcd(x, y);
      return "${a / temp}/${b / temp}";
    }
  }

  //辗转相除法(欧几里德算法) gcd(a,b) = gcd(b,a mod b)  TODO 获得最大公约数
  num _gcd(num x, num y) {
    num r = x % y;
    return r == 0 ? y : _gcd(y, r);
  }
}

void main() {
  var f1 = Fraction(1, 2) + Fraction(1, 2);
  print('f1:${f1.a},${f1.b}');
  var f2 = Fraction(1, 2) + Fraction(1, 3);
  print('f2:${f2.a},${f2.b}');

  var f3 = Fraction(1, 2) * Fraction(2, 1);
  print('f3:${f3.a},${f3.b}');

  print(Fraction(2.1,4.2));
  print(Fraction(6,9));
}

