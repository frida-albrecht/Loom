module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.559000e+01> : tensor<10x9xf32>}> : () -> tensor<10x9xf32>
    %1 = "tosa.const"() <{values = dense<44> : tensor<3x4xi64>}> : () -> tensor<3x4xi64>
    %2 = "tosa.const"() <{values = dense<-141> : tensor<3x4xi64>}> : () -> tensor<3x4xi64>
    %3 = tosa.floor %0 : (tensor<10x9xf32>) -> tensor<10x9xf32>
    %4 = tosa.reverse %3 {axis = 0 : i32} : (tensor<10x9xf32>) -> tensor<10x9xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = tosa.negate %4, %5, %6 : (tensor<10x9xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<10x9xf32>
    %8 = tosa.sigmoid %7 : (tensor<10x9xf32>) -> tensor<10x9xf32>
    %9 = tosa.bitwise_and %1, %2 : (tensor<3x4xi64>, tensor<3x4xi64>) -> tensor<3x4xi64>
    %10 = tosa.bitwise_not %9 : (tensor<3x4xi64>) -> tensor<3x4xi64>
    %cast = tensor.cast %8 : tensor<10x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<3x4xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

