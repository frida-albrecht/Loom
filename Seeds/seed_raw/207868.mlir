module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.609400e+02> : tensor<4x2x9xf32>}> : () -> tensor<4x2x9xf32>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<4x2x9xf32>) -> tensor<1x2x9xf32>
    %2 = tosa.concat %1, %1 {axis = 1 : i32} : (tensor<1x2x9xf32>, tensor<1x2x9xf32>) -> tensor<1x4x9xf32>
    %3 = tosa.floor %2 : (tensor<1x4x9xf32>) -> tensor<1x4x9xf32>
    %4 = tosa.maximum %3, %3 : (tensor<1x4x9xf32>, tensor<1x4x9xf32>) -> tensor<1x4x9xf32>
    %5 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %6 = tosa.transpose %4 {perms = array<i32: 0, 2, 1>} : (tensor<1x4x9xf32>) -> tensor<1x9x4xf32>
    %cast = tensor.cast %6 : tensor<1x9x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

