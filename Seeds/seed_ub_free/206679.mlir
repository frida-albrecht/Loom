module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<144> : tensor<7x2x2x5xi32>}> : () -> tensor<7x2x2x5xi32>
    %1 = "tosa.const"() <{values = dense<7.524000e+01> : tensor<6x9x8xf32>}> : () -> tensor<6x9x8xf32>
    %2 = "tosa.const"() <{values = dense<-3.392000e+01> : tensor<1x1x1xf32>}> : () -> tensor<1x1x1xf32>
    %3 = tosa.argmax %0 {axis = 3 : i32} : (tensor<7x2x2x5xi32>) -> tensor<7x2x2xi32>
    %4 = tosa.pow %1, %2 : (tensor<6x9x8xf32>, tensor<1x1x1xf32>) -> tensor<6x9x8xf32>
    %cast = tensor.cast %3 : tensor<7x2x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<6x9x8xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

