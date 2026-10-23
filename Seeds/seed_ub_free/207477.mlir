module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7x5x10xi1>}> : () -> tensor<7x5x10xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<7x5x10xi1>) -> tensor<5x10xi32>
    %2 = tosa.clamp %1 {max_val = 53 : i32, min_val = -24 : i32} : (tensor<5x10xi32>) -> tensor<5x10xi32>
    %3 = tosa.const_shape  {values = dense<50> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.reshape %2, %3 : (tensor<5x10xi32>, !tosa.shape<1>) -> tensor<50xi32>
    %cast = tensor.cast %4 : tensor<50xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

