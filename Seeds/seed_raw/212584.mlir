module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<86.7799987> : tensor<1x4x10xf32>}> : () -> tensor<1x4x10xf32>
    %1 = "tosa.const"() <{values = dense<5.467000e+01> : tensor<1x4x1xf32>}> : () -> tensor<1x4x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<1x4x10xf32>, tensor<1x4x1xf32>) -> tensor<1x4x10xf32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<1x4x10xf32>) -> tensor<1x4x10xf32>
    %4 = tosa.minimum %3, %2 : (tensor<1x4x10xf32>, tensor<1x4x10xf32>) -> tensor<1x4x10xf32>
    %5 = tosa.reduce_min %4 {axis = 2 : i32} : (tensor<1x4x10xf32>) -> tensor<1x4x1xf32>
    %6 = tosa.reduce_product %5 {axis = 0 : i32} : (tensor<1x4x1xf32>) -> tensor<1x4x1xf32>
    %cast = tensor.cast %6 : tensor<1x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

