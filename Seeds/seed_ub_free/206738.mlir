module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-39> : tensor<10x7x4xi64>}> : () -> tensor<10x7x4xi64>
    %1 = "tosa.const"() <{values = dense<-184> : tensor<10x4x4xi64>}> : () -> tensor<10x4x4xi64>
    %2 = "tosa.const"() <{values = dense<1.498400e+02> : tensor<3x2x2x2xf32>}> : () -> tensor<3x2x2x2xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<10x7x4xi64>, tensor<10x4x4xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<10x7x4xi64>
    %6 = tosa.identity %5 : (tensor<10x7x4xi64>) -> tensor<10x7x4xi64>
    %7 = tosa.reciprocal %2 : (tensor<3x2x2x2xf32>) -> tensor<3x2x2x2xf32>
    %cast = tensor.cast %6 : tensor<10x7x4xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<3x2x2x2xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

