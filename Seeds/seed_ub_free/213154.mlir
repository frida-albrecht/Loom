module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<166> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = "tosa.const"() <{values = dense<103> : tensor<4xi32>}> : () -> tensor<4xi32>
    %3 = tosa.clz %0 : (tensor<4xi8>) -> tensor<4xi8>
    %4 = tosa.intdiv %1, %2 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %cast = tensor.cast %3 : tensor<4xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %4 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

