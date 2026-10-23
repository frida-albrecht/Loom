module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.224000e+01> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = tosa.ceil %0 : (tensor<5xf32>) -> tensor<5xf32>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<i32>
    %3 = tosa.log %1 : (tensor<5xf32>) -> tensor<5xf32>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

