module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.028000e+01> : tensor<8x7xf32>}> : () -> tensor<8x7xf32>
    %1 = tosa.log %0 : (tensor<8x7xf32>) -> tensor<8x7xf32>
    %2 = tosa.concat %1, %1 {axis = 0 : i32} : (tensor<8x7xf32>, tensor<8x7xf32>) -> tensor<16x7xf32>
    %cast = tensor.cast %2 : tensor<16x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

