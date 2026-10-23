module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-93> : tensor<9x5x8x2xi16>}> : () -> tensor<9x5x8x2xi16>
    %1 = "tosa.const"() <{values = dense<188> : tensor<6x1x5x1xi32>}> : () -> tensor<6x1x5x1xi32>
    %2 = "tosa.const"() <{values = dense<-118> : tensor<6x1x1x1xi32>}> : () -> tensor<6x1x1x1xi32>
    %3 = tosa.bitwise_not %0 : (tensor<9x5x8x2xi16>) -> tensor<9x5x8x2xi16>
    %4 = tosa.minimum %1, %2 : (tensor<6x1x5x1xi32>, tensor<6x1x1x1xi32>) -> tensor<6x1x5x1xi32>
    %5 = tosa.clz %3 : (tensor<9x5x8x2xi16>) -> tensor<9x5x8x2xi16>
    %6 = tosa.bitwise_or %5, %3 : (tensor<9x5x8x2xi16>, tensor<9x5x8x2xi16>) -> tensor<9x5x8x2xi16>
    %cast = tensor.cast %4 : tensor<6x1x5x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<9x5x8x2xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

