module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.673700e+02> : tensor<8x10x6xf32>}> : () -> tensor<8x10x6xf32>
    %1 = "tosa.const"() <{values = dense<-1.024000e+02> : tensor<8x6x7xf32>}> : () -> tensor<8x6x7xf32>
    %2 = "tosa.const"() <{values = dense<26> : tensor<9x7xi64>}> : () -> tensor<9x7xi64>
    %3 = "tosa.const"() <{values = dense<-147> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.matmul %0, %1, %4, %5 : (tensor<8x10x6xf32>, tensor<8x6x7xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<8x10x7xf32>
    %7 = tosa.reduce_max %6 {axis = 0 : i32} : (tensor<8x10x7xf32>) -> tensor<1x10x7xf32>
    %8 = tosa.arithmetic_right_shift %2, %3 {round = true} : (tensor<9x7xi64>, tensor<1x1xi64>) -> tensor<9x7xi64>
    %9 = tosa.reduce_product %7 {axis = 1 : i32} : (tensor<1x10x7xf32>) -> tensor<1x1x7xf32>
    %cast = tensor.cast %8 : tensor<9x7xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %9 : tensor<1x1x7xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

