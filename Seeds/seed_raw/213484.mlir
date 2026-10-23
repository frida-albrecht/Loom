module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-27> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<41> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<-3.999000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %3 = tosa.minimum %0, %1 : (tensor<2xi64>, tensor<1xi64>) -> tensor<2xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.transpose %3 {perms = array<i32: 0>} : (tensor<2xi64>) -> tensor<2xi64>
    %6 = tosa.bitwise_not %5 : (tensor<2xi64>) -> tensor<2xi64>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %9 = tosa.negate %6, %7, %8 : (tensor<2xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<2xi64>
    %10 = tosa.identity %9 : (tensor<2xi64>) -> tensor<2xi64>
    %11 = tosa.tanh %2 : (tensor<6xf32>) -> tensor<6xf32>
    %12 = tosa.log %11 : (tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %10 : tensor<2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %12 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

