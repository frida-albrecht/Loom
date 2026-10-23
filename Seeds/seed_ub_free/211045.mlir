module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<5x10x6xi8>}> : () -> tensor<5x10x6xi8>
    %1 = tosa.identity %0 : (tensor<5x10x6xi8>) -> tensor<5x10x6xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.negate %1, %2, %3 : (tensor<5x10x6xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<5x10x6xi8>
    %5 = tosa.add %4, %4 : (tensor<5x10x6xi8>, tensor<5x10x6xi8>) -> tensor<5x10x6xi8>
    %cast = tensor.cast %5 : tensor<5x10x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

