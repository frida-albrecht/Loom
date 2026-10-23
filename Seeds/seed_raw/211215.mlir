module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.641000e+01> : tensor<1x8x4x5xf32>}> : () -> tensor<1x8x4x5xf32>
    %1 = tosa.sigmoid %0 : (tensor<1x8x4x5xf32>) -> tensor<1x8x4x5xf32>
    %2 = tosa.reduce_min %1 {axis = 0 : i32} : (tensor<1x8x4x5xf32>) -> tensor<1x8x4x5xf32>
    %cast = tensor.cast %2 : tensor<1x8x4x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

