module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.875900e+02> : tensor<4x7xf32>}> : () -> tensor<4x7xf32>
    %1 = "tosa.const"() <{values = dense<5.365000e+01> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %2 = tosa.maximum %0, %1 : (tensor<4x7xf32>, tensor<1x7xf32>) -> tensor<4x7xf32>
    %3 = tosa.equal %2, %2 : (tensor<4x7xf32>, tensor<4x7xf32>) -> tensor<4x7xi1>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<4x7xi1>) -> tensor<1x7xi1>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<1x7xi1>) -> tensor<7xi32>
    %6 = tosa.log %2 : (tensor<4x7xf32>) -> tensor<4x7xf32>
    %cast = tensor.cast %5 : tensor<7xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<4x7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

