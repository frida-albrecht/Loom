module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-42> : tensor<5x1x1x7xi64>}> : () -> tensor<5x1x1x7xi64>
    %1 = "tosa.const"() <{values = dense<-4.126000e+01> : tensor<9x1x4xf32>}> : () -> tensor<9x1x4xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<5x1x1x7xi64>) -> tensor<1x1x1x7xi64>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<1x1x1x7xi64>) -> tensor<1x1x1x7xi64>
    %4 = tosa.abs %3 : (tensor<1x1x1x7xi64>) -> tensor<1x1x1x7xi64>
    %5 = tosa.rsqrt %1 : (tensor<9x1x4xf32>) -> tensor<9x1x4xf32>
    %cast = tensor.cast %4 : tensor<1x1x1x7xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<9x1x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

