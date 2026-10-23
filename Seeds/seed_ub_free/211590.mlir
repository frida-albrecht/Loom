module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.449700e+02> : tensor<4x8x10xf32>}> : () -> tensor<4x8x10xf32>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<4x8x10xf32>) -> tensor<4x8x1xf32>
    %2 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %3 = tosa.transpose %1 {perms = array<i32: 0, 2, 1>} : (tensor<4x8x1xf32>) -> tensor<4x1x8xf32>
    %4 = tosa.pow %3, %3 : (tensor<4x1x8xf32>, tensor<4x1x8xf32>) -> tensor<4x1x8xf32>
    %cast = tensor.cast %4 : tensor<4x1x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

