module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-74> : tensor<9x4xi32>}> : () -> tensor<9x4xi32>
    %1 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 1>} : (tensor<9x4xi32>) -> tensor<9x4xi32>
    %3 = tosa.abs %2 : (tensor<9x4xi32>) -> tensor<9x4xi32>
    %cast = tensor.cast %3 : tensor<9x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

