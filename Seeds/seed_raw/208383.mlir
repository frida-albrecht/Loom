module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.881000e+01> : tensor<5x6x10xf32>}> : () -> tensor<5x6x10xf32>
    %1 = "tosa.const"() <{values = dense<2.558000e+01> : tensor<7x4x4x1xf32>}> : () -> tensor<7x4x4x1xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<5x6x10xf32>) -> tensor<6x10xi32>
    %3 = tosa.tanh %1 : (tensor<7x4x4x1xf32>) -> tensor<7x4x4x1xf32>
    %cast = tensor.cast %2 : tensor<6x10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<7x4x4x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

