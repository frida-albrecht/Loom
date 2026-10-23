module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-53> : tensor<6x4x5x6xi32>}> : () -> tensor<6x4x5x6xi32>
    %1 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 3, 1, 2>} : (tensor<6x4x5x6xi32>) -> tensor<6x6x4x5xi32>
    %cast = tensor.cast %2 : tensor<6x6x4x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

