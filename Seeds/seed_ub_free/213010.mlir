module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<6x1xi1>}> : () -> tensor<6x1xi1>
    %1 = "tosa.const"() <{values = dense<4.859000e+01> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = tosa.argmax %0 {axis = 1 : i32} : (tensor<6x1xi1>) -> tensor<6xi32>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<6xi32>) -> tensor<i32>
    %4 = tosa.tanh %1 : (tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

