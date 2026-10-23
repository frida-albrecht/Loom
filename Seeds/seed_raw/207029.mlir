module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<61> : tensor<10x1x7x5xi64>}> : () -> tensor<10x1x7x5xi64>
    %1 = "tosa.const"() <{values = dense<-63> : tensor<10x1x7x1xi64>}> : () -> tensor<10x1x7x1xi64>
    %2 = "tosa.const"() <{values = dense<-2.755000e+01> : tensor<3x9x4xf32>}> : () -> tensor<3x9x4xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<10x1x7x5xi64>, tensor<10x1x7x1xi64>) -> tensor<10x1x7x5xi64>
    %4 = tosa.reduce_max %3 {axis = 2 : i32} : (tensor<10x1x7x5xi64>) -> tensor<10x1x1x5xi64>
    %5 = tosa.ceil %2 : (tensor<3x9x4xf32>) -> tensor<3x9x4xf32>
    %cast = tensor.cast %4 : tensor<10x1x1x5xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<3x9x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

