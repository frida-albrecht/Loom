module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.099000e+01> : tensor<8x4x4xf32>}> : () -> tensor<8x4x4xf32>
    %1 = tosa.identity %0 : (tensor<8x4x4xf32>) -> tensor<8x4x4xf32>
    %cast = tensor.cast %1 : tensor<8x4x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

