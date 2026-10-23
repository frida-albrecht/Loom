module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.359300e+02> : tensor<8x10x2x6xf32>}> : () -> tensor<8x10x2x6xf32>
    %1 = tosa.log %0 : (tensor<8x10x2x6xf32>) -> tensor<8x10x2x6xf32>
    %2 = tosa.sigmoid %1 : (tensor<8x10x2x6xf32>) -> tensor<8x10x2x6xf32>
    %3 = tosa.concat %2, %1 {axis = 1 : i32} : (tensor<8x10x2x6xf32>, tensor<8x10x2x6xf32>) -> tensor<8x20x2x6xf32>
    %4 = tosa.clamp %3 {max_val = 8.200000e+01 : f32, min_val = -3.300000e+01 : f32} : (tensor<8x20x2x6xf32>) -> tensor<8x20x2x6xf32>
    %cast = tensor.cast %4 : tensor<8x20x2x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

