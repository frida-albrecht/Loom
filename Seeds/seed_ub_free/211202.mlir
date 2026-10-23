module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.966100e+02> : tensor<8x8x9xf32>}> : () -> tensor<8x8x9xf32>
    %1 = tosa.log %0 : (tensor<8x8x9xf32>) -> tensor<8x8x9xf32>
    %2 = tosa.reduce_min %1 {axis = 0 : i32} : (tensor<8x8x9xf32>) -> tensor<1x8x9xf32>
    %3 = tosa.log %2 : (tensor<1x8x9xf32>) -> tensor<1x8x9xf32>
    %4 = tosa.reverse %3 {axis = 2 : i32} : (tensor<1x8x9xf32>) -> tensor<1x8x9xf32>
    %cast = tensor.cast %4 : tensor<1x8x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

