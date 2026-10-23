module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.744100e+02> : tensor<8x7x10x7xf32>}> : () -> tensor<8x7x10x7xf32>
    %1 = tosa.reduce_product %0 {axis = 2 : i32} : (tensor<8x7x10x7xf32>) -> tensor<8x7x1x7xf32>
    %cast = tensor.cast %1 : tensor<8x7x1x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

