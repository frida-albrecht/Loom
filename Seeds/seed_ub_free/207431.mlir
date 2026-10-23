module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.005200e+02> : tensor<2x6x9x4xf32>}> : () -> tensor<2x6x9x4xf32>
    %1 = tosa.floor %0 : (tensor<2x6x9x4xf32>) -> tensor<2x6x9x4xf32>
    %2 = tosa.argmax %1 {axis = 3 : i32} : (tensor<2x6x9x4xf32>) -> tensor<2x6x9xi32>
    %3 = tosa.ceil %1 : (tensor<2x6x9x4xf32>) -> tensor<2x6x9x4xf32>
    %cast = tensor.cast %2 : tensor<2x6x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<2x6x9x4xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

