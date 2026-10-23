module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.678500e+02> : tensor<8x10x1xf32>}> : () -> tensor<8x10x1xf32>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<8x10x1xf32>) -> tensor<1x10x1xf32>
    %cast = tensor.cast %1 : tensor<1x10x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

