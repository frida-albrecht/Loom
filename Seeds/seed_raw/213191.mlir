module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<127> : tensor<9x6x4xi32>}> : () -> tensor<9x6x4xi32>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<9x6x4xi32>) -> tensor<9x6x1xi32>
    %cast = tensor.cast %1 : tensor<9x6x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

