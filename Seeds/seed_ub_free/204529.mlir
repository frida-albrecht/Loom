module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<24> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<-7.882000e+01> : tensor<9x8x3xf32>}> : () -> tensor<9x8x3xf32>
    %2 = tosa.identity %0 : (tensor<2xi64>) -> tensor<2xi64>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<2xi64>) -> tensor<2xi64>
    %4 = tosa.ceil %1 : (tensor<9x8x3xf32>) -> tensor<9x8x3xf32>
    %5 = tosa.ceil %4 : (tensor<9x8x3xf32>) -> tensor<9x8x3xf32>
    %cast = tensor.cast %3 : tensor<2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<9x8x3xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

